import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="typewriter"
export default class extends Controller {
  static targets = ["quote", "cursor", "source"];

  connect() {
    const typedTextSpan = this.quoteTarget;
    const cursorSpan = this.cursorTarget;
    const source = this.sourceTarget;
    const textArray = ['Be like water, my friend!', 'My opponent is my teacher, my ego is my enemy', 'Jiu jitsu is the science and art of control that leads to submission'];
    const peopleArray = ['- Bruce Lee', '- Renzo Gracie', '- John Danaher'];

    const typingDelay = 100;
    const erasingDelay = 50;
    const newTextDelay = 5000; // Delay between current and next text

    let charIndex = 0;
    let textArrayIndex = 0;

    if(textArray.length) setTimeout(type, 1000);

    function type() {
      if (charIndex < textArray[textArrayIndex].length) {
        if(!cursorSpan.classList.contains("typing")) cursorSpan.classList.add("typing");
        typedTextSpan.textContent += textArray[textArrayIndex].charAt(charIndex);
        charIndex++;
        setTimeout(type, typingDelay);
      }
      else {
        cursorSpan.classList.remove("typing");
        source.innerText = peopleArray[textArrayIndex];
        source.style.opacity = 1;
        setTimeout(erase, newTextDelay);
      }
    }

    function erase() {
      source.style.opacity = 0;
      if (charIndex > 0) {
        if(!cursorSpan.classList.contains("typing")) cursorSpan.classList.add("typing");
        typedTextSpan.textContent = textArray[textArrayIndex].substring(0, charIndex-1);
        charIndex--;
        setTimeout(erase, erasingDelay);
      }
      else {
        cursorSpan.classList.remove("typing");
        textArrayIndex++;
        if(textArrayIndex>=textArray.length) textArrayIndex=0;
        setTimeout(type, 1000);
      }
    }
  }
}
