 ```

             ██▀███   ▒█████   ▒█████    ██████ ▄▄▄█████▓▓█████  ██▀███      ██▀███   ▄████▄
            ▓██ ▒ ██▒▒██▒  ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒   ▓██ ▒ ██▒▒██▀ ▀█
            ▓██ ░▄█ ▒▒██░  ██▒▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒   ▓██ ░▄█ ▒▒▓█    ▄
            ▒██▀▀█▄  ▒██   ██░▒██   ██░  ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄     ▒██▀▀█▄  ▒▓▓▄ ▄██▒
            ░██▓ ▒██▒░ ████▓▒░░ ████▓▒░▒██████▒▒  ▒██▒ ░ ░▒████▒░██▓ ▒██▒   ░██▓ ▒██▒▒ ▓███▀ ░
            ░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▒▓ ░▒▓░░ ░▒ ▒  ░
              ░▒ ░ ▒░  ░ ▒ ▒░   ░ ▒ ▒░ ░ ░▒  ░ ░    ░     ░ ░  ░  ░▒ ░ ▒░     ░▒ ░ ▒░  ░  ▒
              ░░   ░ ░ ░ ░ ▒  ░ ░ ░ ▒  ░  ░  ░    ░         ░     ░░   ░      ░░   ░ ░
               ░         ░ ░      ░ ░        ░              ░  ░   ░           ░     ░ ░
                                                                                     ░
                                       Big Thanks To ThePrimeagen
                                          .".".".
                                        (`       `)               _.-=-.
                                         '._.--.-;             .-`  -'  '.
                                        .-'`.o )  \           /  .-_.--'  `\
                                       `;---) \    ;         /  / ;' _-_.-' `
                                         `;"`  ;    \        ; .  .'   _-' \
                                          (    )    |        |  / .-.-'    -`
                                           '-.-'     \       | .' ` '.-'-\`
                                            /_./\_.|\_\      ;  ' .'-'.-.
                                            /         '-._    \` /  _;-,
                                           |         .-=-.;-._ \  -'-,
                                           \        /      `";`-`,-"`)
                                            \       \     '-- `\.\
                                             '.      '._ '-- '--'/
                                               `-._     `'----'`;
                                                   `"""--.____,/
                                                          \\  \
                                                          // /`
                                                      ___// /__
                                                    (`(`(---"-`)
```

> “I don't wanna be a referee.
> Being a referee is effectively being someone
> who sits next to the game,
> who knows everything about the game,
> and they only call out where people have done things wrong in the game.
> They neither know the heights of winning
> nor the depths of losing.
> I don't wanna be a referee,
>  I wanna be someone who genuinely tries.”
>
> -- ThePrimeagen


### Quick Coding Challenge:

Update the following code to no longer use branching but arithmetic instead. Bonus points if you do it without introducing any memory allocations.

```typescript
export default class UUID {
  static generate(): string {
    const randomBytes = [];

    for (let i = 0; i < 16; ++i) {
      let randomValue = Math.random() * 0x100 | 0;

      // Ensure 6th byte high nib = 4, ensure 8th byte high = "8", "9", "A" or "B".
      if (i === 6) {
        randomValue = (0x40 | (randomValue & 0xf));
      } else if (i === 8) {
        randomValue = (0x80 | (randomValue & 0x3f));
      }

      const highNibble = (randomValue >>> 4).toString(16);
      const lowNibble = (randomValue & 0xf).toString(16);
      randomBytes[i] = highNibble + lowNibble;
    }

    let rHex = randomBytes.join('');
    return rHex.substring(0, 8) + "-" + rHex.substring(8, 12) + "-" + rHex.substring(12, 16) + "-" + rHex.substring(16, 20) + "-" + rHex.substring(20, 32);
  }
}
```

<details>
<summary>Click to reveal answer</summary>

```typescript
export default class UUID {
  static generate(): string {
    const randomBytes = [];

    for (let i = 0; i < 16; ++i) {
      let randomValue = Math.random() * 0x100 | 0;
      randomValue = (randomValue & ~(~~(i === 6) * 0xf0 | ~~(i === 8) * 0xc0)) | (~~(i === 6) * 0x40) | (~~(i === 8) * 0x80);
      randomBytes[i] = (randomValue >>> 4).toString(16) + (randomValue & 0xf).toString(16);
    }

    let rHex = randomBytes.join('');
    return rHex.substring(0, 8) + "-" + rHex.substring(8, 12) + "-" + rHex.substring(12, 16) + "-" + rHex.substring(16, 20) + "-" + rHex.substring(20, 32);
  }
}
```

</details>

