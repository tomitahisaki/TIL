function reversePrefix(word: string, ch: string): string {
  const index = word.indexOf(ch);
  if (index === -1) return word;
  const prefix = word
    .substring(0, index + 1)
    .split("")
    .reverse()
    .join("");
  return prefix + word.substring(index + 1);
}
