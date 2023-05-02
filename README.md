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


### Quick Coding Challenge

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

Learning and applying optimizations like the one in the provided code can provide various benefits, including:

1. **Performance improvement**: Optimizations can lead to faster code execution, which is crucial in performance-critical applications, real-time systems, and large-scale data processing tasks.

2. **Resource efficiency**: Optimized code can reduce memory allocations and CPU usage, enabling applications to run on devices with limited resources, such as embedded systems or low-end hardware.

3. **Better understanding of the language**: Exploring different optimization techniques helps deepen your understanding of the programming language and its underlying mechanisms. This knowledge can be beneficial when tackling complex problems or developing high-performance applications.

4. **Competitive advantage**: Demonstrating the ability to optimize code effectively can set you apart from other developers, making you a valuable asset in a team or organization. It can also help improve your problem-solving skills and make you more proficient in coding interviews.

5. **Code readability and maintainability**: Some optimizations, such as removing branching or reducing code complexity, can lead to more concise and readable code. This can make it easier for others to understand, maintain, and extend the codebase in the future.

However, it's essential to strike a balance between optimization and code readability. Over-optimizing code can sometimes lead to reduced readability and maintainability, which can negatively impact the overall development process.

