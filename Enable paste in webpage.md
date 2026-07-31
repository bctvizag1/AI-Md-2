## Enable paste in webpage

Warning: Don’t paste code into the DevTools Console that you don’t understand or haven’t reviewed yourself. This could allow attackers to steal your identity or take control of your computer. Please type “allow pasting” below and press Enter to allow pasting
```console
allow pasting
```
### paste in consle
```js
var allowCopyAndPaste = function (e) { e.stopImmediatePropagation(); return true; };
document.addEventListener("copy", allowCopyAndPaste, true);
document.addEventListener("paste", allowCopyAndPaste, true);
document.addEventListener("onpaste", allowCopyAndPaste, true);
```