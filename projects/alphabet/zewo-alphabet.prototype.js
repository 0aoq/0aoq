// 0aoq - Licensed under the MIT license, https://github.com/0aoq/0aoq/blob/main/LICENSE

const alphabet = [ // letter replacements
    { from: "a", to: "r" },
    { from: "b", to: "b" },
    { from: "c", to: "k" },
    { from: "d", to: "t" },
    { from: "e", to: "'o" },
    { from: "f", to: "z" },
    { from: "g", to: "m" },
    { from: "h", to: "a" },
    { from: "i", to: "w'" },
    { from: "j", to: "q" },
    { from: "k", to: "n" },
    { from: "l", to: "l" },
    { from: "m", to: "i" },
    { from: "n", to: "v" },
    { from: "o", to: "x" },
    { from: "p", to: "e" },
    { from: "q", to: "s" },
    { from: "r", to: "c" },
    { from: "s", to: "j" },
    { from: "t", to: "u" },
    { from: "u", to: "f" },
    { from: "v", to: "d" },
    { from: "w", to: "g" },
    { from: "x", to: "y" },
    { from: "y", to: "p" },
    { from: "z", to: "h" },
]

class ZewoAlphabet {
    constructor() {
        this.illegal = `<>0123456789![](){}';:/$.,=-+*&^%$#@~"'| \n\r`
        this.checkIllegal = function(string) { return this.illegal.includes(string) }

        this.getLetter = function(l) {
            // return a letter.to value from a letter.from
            for (let letter of alphabet) {
                if (!this.checkIllegal(l)) {
                    if (letter.from === l) { return letter.to }
                } else {
                    return l
                }
            }
        }

        this.parse = function(string) {
            let str = []

            // put all letters into an array
            for (let i = 0; i < string.length; i++) { str.push(string.charAt(i)) }

            // handle letter switching
            string = ""

            for (let l of str) {
                // replace letter
                let $ = this.getLetter(l.toString().toLowerCase()) || ""
                if (l === l.toUpperCase()) { string += $.toUpperCase() } else { string += $ }
            }

            // return final
            return string
        }
    }
}