#!/bin/bash

RED=$'\e[91m'      # Bright Red
GREEN=$'\e[92m'    # Bright Green 
YELLOW=$'\e[93m'   # Bright Yellow
CYAN=$'\e[96m'     # Bright Cyan
NC=$'\e[0m'        # No Color

show_usage() {
    echo "Usage: $0 [JWT_TOKEN]"
    echo "       echo 'JWT_TOKEN' | $0"
    echo "       wgc | $0"
    echo ""
    echo "Examples:"
    echo "  $0 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    echo "  echo 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' | $0"
    echo "  wgc | $0"
}

decode_base64url() {
    local input="$1"
    input="${input//_/\/}"
    input="${input//-/+}"
    
    local padding=$((4 - ${#input} % 4))
    if [ $padding -ne 4 ]; then
        input="${input}$(printf '%*s' $padding | tr ' ' '=')"
    fi
    
    echo "$input" | base64 -d 2>/dev/null
}

extract_json_pairs() {
    local json="$1"
    
    if command -v jq >/dev/null 2>&1; then
        echo "$json" | jq -r 'to_entries[] | if (.value | type) == "array" then "\(.key)|\(.value | join("\n"))" else "\(.key)|\(.value)" end'
    else
        echo "$json" | sed 's/[{}]//g' | sed 's/","/ /g' | sed 's/^"//; s/"$//' | tr ',' '\n' | while IFS=':' read -r key value; do
            key=$(echo "$key" | sed 's/^"//; s/"$//' | sed 's/^[[:space:]]*//')
            value=$(echo "$value" | sed 's/^"//; s/"$//' | sed 's/^[[:space:]]*//')
            
            if [[ "$value" =~ ^\[.*\]$ ]]; then
                array_content=$(echo "$value" | sed 's/^\[//; s/\]$//')
                formatted_value=$(echo "$array_content" | sed 's/","/\n/g' | sed 's/^"//; s/"$//')
                echo "$key|$formatted_value"
            else
                echo "$key|$value"
            fi
        done
    fi
}

format_section() {
    local title="$1"
    local title_color="$2"
    local data="$3"
    
    echo -e "\n${title_color}$title${NC}"
    
    local max_key_length=0
    while IFS='|' read -r key value; do
        if [ ${#key} -gt $max_key_length ]; then
            max_key_length=${#key}
        fi
    done <<< "$data"
    
    local current_key=""
    local is_first_value=true
    
    echo "$data" | while IFS= read -r line; do
        if [[ "$line" == *"|"* ]]; then
            IFS='|' read -r key value <<< "$line"
            printf "${CYAN}%-${max_key_length}s${NC} ${GREEN}%s${NC}\n" "$key" "$value"
            current_key="$key"
            is_first_value=false
        else
            if [[ -n "$line" ]]; then
                printf "%*s ${GREEN}%s${NC}\n" "$max_key_length" "" "$line"
            fi
        fi
    done
}

format_signature_section() {
    local signature="$1"
    
    echo -e "\n${YELLOW}Signature (Base64 URL)${NC}"
    echo -e "${GREEN}$signature${NC}"
}

check_token_expiration() {
    local payload_json="$1"
    
    if command -v jq >/dev/null 2>&1; then
        local exp=$(echo "$payload_json" | jq -r '.exp // empty' 2>/dev/null)
    else
        local exp=$(echo "$payload_json" | grep -o '"exp":[^,}]*' | cut -d':' -f2 | tr -d '"' | tr -d ' ')
    fi
    
    if [ -n "$exp" ] && [ "$exp" != "null" ]; then
        if [ ${#exp} -gt 10 ]; then
            exp=$((exp / 1000))
        fi
        
        local current_time=$(date +%s)
        
        if [ "$exp" -lt "$current_time" ]; then
            echo "Expired"
        else
            local time_diff=$((exp - current_time))
            local days=$((time_diff / 86400))
            local hours=$(((time_diff % 86400) / 3600))
            local minutes=$(((time_diff % 3600) / 60))
            local seconds=$((time_diff % 60))
            
            echo "Not Expired (Expires in $days days, $hours hours, $minutes minutes, $seconds seconds)"
        fi
    else
        echo "No Expiry Claim"
    fi
}

discover_jwks_endpoint() {
    local issuer="$1"
    
    if [ -z "$issuer" ]; then
        return 1
    fi
    
    local discovery_url="${issuer}/.well-known/openid-configuration"
    
    if command -v curl >/dev/null 2>&1; then
        local discovery_content=$(curl -s -f "$discovery_url" 2>/dev/null)
        if [ -n "$discovery_content" ]; then
            local jwks_uri
            if command -v jq >/dev/null 2>&1; then
                jwks_uri=$(echo "$discovery_content" | jq -r '.jwks_uri // empty' 2>/dev/null)
            else
                jwks_uri=$(echo "$discovery_content" | grep -o '"jwks_uri":"[^"]*"' | cut -d'"' -f4)
            fi
            
            if [ -n "$jwks_uri" ] && [ "$jwks_uri" != "null" ]; then
                echo "$jwks_uri"
                return 0
            fi
        fi
    fi
    
    case "$issuer" in
        *"googleapis.com"*|*"accounts.google.com"*)
            echo "https://www.googleapis.com/oauth2/v3/certs"
            ;;
        *"auth0.com"*)
            echo "${issuer}/.well-known/jwks.json"
            ;;
        *)
            echo "${issuer}/.well-known/jwks.json"
            ;;
    esac
}

extract_public_key() {
    local jwks_endpoint="$1"
    local kid="$2"
    
    if [ -z "$jwks_endpoint" ] || [ -z "$kid" ]; then
        return 1
    fi
    
    local jwks_content
    if command -v curl >/dev/null 2>&1; then
        jwks_content=$(curl -s -f "$jwks_endpoint" 2>/dev/null)
    else
        return 1
    fi
    
    if [ -z "$jwks_content" ]; then
        return 1
    fi
    
    local modulus exponent
    if command -v jq >/dev/null 2>&1; then
        modulus=$(echo "$jwks_content" | jq -r ".keys[] | select(.kid == \"$kid\") | .n // empty" 2>/dev/null)
        exponent=$(echo "$jwks_content" | jq -r ".keys[] | select(.kid == \"$kid\") | .e // empty" 2>/dev/null)
    else
        local key_block=$(echo "$jwks_content" | sed -n "/${kid}/,/}/p" | head -20)
        modulus=$(echo "$key_block" | grep -o '"n":"[^"]*"' | cut -d'"' -f4)
        exponent=$(echo "$key_block" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
    fi
    
    if [ -n "$modulus" ] && [ -n "$exponent" ] && [ "$modulus" != "null" ] && [ "$exponent" != "null" ]; then
        echo "n=$modulus"
        echo "e=$exponent"
        return 0
    fi
    
    return 1
}

base64url_to_base64() {
    local input="$1"
    input="${input//_/\/}"
    input="${input//-/+}"
    
    local padding=$((4 - ${#input} % 4))
    if [ $padding -ne 4 ]; then
        input="${input}$(printf '%*s' $padding | tr ' ' '=')"
    fi
    
    echo "$input"
}

verify_rsa_signature() {
    local header_b64="$1"
    local payload_b64="$2"
    local signature_b64="$3"
    local modulus_b64="$4"
    local exponent_b64="$5"
    local algorithm="$6"
    local signing_input="${header_b64}.${payload_b64}"
    local signature_b64_std=$(base64url_to_base64 "$signature_b64")
    local temp_dir=$(mktemp -d)
    local pub_key_file="$temp_dir/pubkey.pem"
    local signature_file="$temp_dir/signature.bin"
    local data_file="$temp_dir/data.txt"
    local modulus_std=$(base64url_to_base64 "$modulus_b64")
    local exponent_std=$(base64url_to_base64 "$exponent_b64")
    
    echo "$modulus_std" | base64 -d > "$temp_dir/modulus.bin" 2>/dev/null
    echo "$exponent_std" | base64 -d > "$temp_dir/exponent.bin" 2>/dev/null
    
    if command -v openssl >/dev/null 2>&1; then
        rm -rf "$temp_dir"
        echo "RSA_COMPONENTS:n=$modulus_b64,e=$exponent_b64"
        return 2
    fi
    
    rm -rf "$temp_dir"
    return 1
}

validate_jwt_signature() {
    local header_json="$1"
    local payload_json="$2"
    local header_b64="$3"
    local payload_b64="$4"
    local signature_b64="$5"
    
    local alg kid issuer
    if command -v jq >/dev/null 2>&1; then
        alg=$(echo "$header_json" | jq -r '.alg // empty' 2>/dev/null)
        kid=$(echo "$header_json" | jq -r '.kid // empty' 2>/dev/null)
        issuer=$(echo "$payload_json" | jq -r '.iss // empty' 2>/dev/null)
    else
        alg=$(echo "$header_json" | grep -o '"alg":"[^"]*"' | cut -d'"' -f4)
        kid=$(echo "$header_json" | grep -o '"kid":"[^"]*"' | cut -d'"' -f4)
        issuer=$(echo "$payload_json" | grep -o '"iss":"[^"]*"' | cut -d'"' -f4)
    fi
    
    if [ -z "$alg" ]; then
        echo "Cannot validate - missing signature algorithm"
        return 1
    fi
    
    case "$alg" in
        "RS256"|"RS384"|"RS512")
            # RSA algorithms - attempt automatic validation
            ;;
        "HS256"|"HS384"|"HS512")
            echo "HMAC signature detected - requires shared secret (not publicly verifiable)"
            return 1
            ;;
        *)
            echo "Unsupported signature algorithm: $alg"
            return 1
            ;;
    esac
    
    if [ -n "$issuer" ] && [ -n "$kid" ]; then
        echo "Attempting automatic signature validation..."
        echo "- Issuer: $issuer"
        echo "- Key ID: $kid"
        echo "- Algorithm: $alg"
        
        local jwks_endpoint=$(discover_jwks_endpoint "$issuer")
        if [ -z "$jwks_endpoint" ]; then
            echo "- Status: Failed to discover JWKS endpoint"
            return 1
        fi
        
        echo "- JWKS Endpoint: $jwks_endpoint"
        
        local key_info=$(extract_public_key "$jwks_endpoint" "$kid")
        if [ $? -ne 0 ] || [ -z "$key_info" ]; then
            echo "- Status: Failed to retrieve public key from JWKS"
            echo "- Manual verification: Use public key from JWKS endpoint above"
            return 1
        fi
        
        local modulus=$(echo "$key_info" | grep '^n=' | cut -d'=' -f2)
        local exponent=$(echo "$key_info" | grep '^e=' | cut -d'=' -f2)
        
        if [ -n "$modulus" ] && [ -n "$exponent" ]; then
            local verify_result=$(verify_rsa_signature "$header_b64" "$payload_b64" "$signature_b64" "$modulus" "$exponent" "$alg")
            local verify_status=$?
            
            if [ $verify_status -eq 0 ]; then
                echo "- Status: ✓ Signature verified successfully"
            elif [ $verify_status -eq 2 ]; then
                echo "- Status: Key components retrieved (OpenSSL verification complex)"
                echo "- Manual verification: Use modulus and exponent from JWKS"
            else
                echo "- Status: ✗ Signature verification failed"
            fi
        else
            echo "- Status: Failed to parse RSA key components"
            echo "- Manual verification: Use public key from JWKS endpoint above"
        fi
    elif [ -n "$issuer" ]; then
        local jwks_endpoint=$(discover_jwks_endpoint "$issuer")
        echo "Automatic validation not possible:"
        echo "- Issuer: $issuer"
        echo "- Algorithm: $alg"
        echo "- JWKS Endpoint: $jwks_endpoint"
        echo "- Status: No key ID specified in JWT header"
        echo "- Manual verification: Find appropriate key in JWKS endpoint"
    else
        echo "Automatic validation not possible:"
        echo "- Algorithm: $alg"
        echo "- Status: No issuer specified in JWT payload"
        echo "- Manual verification: Obtain public key from token issuer"
    fi
    
    return 1
}


parse_jwt() {
    local jwt_token="$1"
    jwt_token=$(echo "$jwt_token" | tr -d '[:space:]')
    
    local dot_count=$(echo "$jwt_token" | grep -o '\.' | wc -l)
    if [ "$dot_count" -ne 2 ]; then
        echo -e "${RED}Error: Invalid JWT format. A JWT should consist of three parts (header.payload.signature).${NC}" >&2
        return 1
    fi
    
    IFS='.' read -r header_b64 payload_b64 signature_b64 <<< "$jwt_token"

    local header_json=$(decode_base64url "$header_b64")
    local payload_json=$(decode_base64url "$payload_b64")
    
    if [ -z "$header_json" ] || [ -z "$payload_json" ]; then
        echo -e "${RED}Error: Failed to decode JWT parts. Invalid base64url encoding.${NC}" >&2
        return 1
    fi
    
    local header_pairs=$(extract_json_pairs "$header_json")
    local payload_pairs=$(extract_json_pairs "$payload_json")
    
    format_section "Header Information" "$YELLOW" "$header_pairs"
    format_section "Payload Information" "$YELLOW" "$payload_pairs"
    format_signature_section "$signature_b64"
    
    echo -e "\n${YELLOW}Other Information${NC}"
    
    local expiry_status=$(check_token_expiration "$payload_json")
    printf "${CYAN}%-25s${NC} ${GREEN}%s${NC}\n" "Token Expiration Status" "$expiry_status"
    
    local iat_info=""
    if command -v jq >/dev/null 2>&1; then
        local iat=$(echo "$payload_json" | jq -r '.iat // empty' 2>/dev/null)
    else
        local iat=$(echo "$payload_json" | grep -o '"iat":[^,}]*' | cut -d':' -f2 | tr -d '"' | tr -d ' ')
    fi
    
    if [ -n "$iat" ] && [ "$iat" != "null" ]; then
        if command -v date >/dev/null 2>&1; then
            local readable_date=$(date -d "@$iat" 2>/dev/null || date -r "$iat" 2>/dev/null)
            iat_info="$readable_date"
        else
            iat_info="$iat (timestamp)"
        fi
        printf "${CYAN}%-25s${NC} ${GREEN}%s${NC}\n" "Issued At (iat)" "$iat_info"
    fi
    
    echo ""
    echo -e "${YELLOW}Signature Validation${NC}"
    validate_jwt_signature "$header_json" "$payload_json" "$header_b64" "$payload_b64" "$signature_b64" | while IFS= read -r line; do
        if [[ "$line" == *":"* ]] && [[ "$line" == "- "* ]]; then
            printf "  ${CYAN}%s${NC}\n" "$line"
        else
            printf "  ${GREEN}%s${NC}\n" "$line"
        fi
    done
}

main() {
    local jwt_token=""
    
    if [ -p /dev/stdin ]; then
        jwt_token=$(cat)
    elif [ $# -eq 1 ]; then
        jwt_token="$1"
    elif [ $# -eq 0 ]; then
        echo -e "${RED}Error: No JWT token provided.${NC}" >&2
        show_usage
        exit 1
    else
        echo -e "${RED}Error: Too many arguments.${NC}" >&2
        show_usage
        exit 1
    fi
    
    if [ -z "$jwt_token" ] || [ "$jwt_token" = "" ]; then
        echo -e "${RED}Error: JWT token cannot be empty.${NC}" >&2
        show_usage
        exit 1
    fi
    
    if ! parse_jwt "$jwt_token"; then
        exit 1
    fi
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_usage
    exit 0
fi

main "$@"
