'use strict';

export default function () {
  var scrolled = false;
  document.addEventListener('scroll', () => {
    const scrollTop =
      document.documentElement.scrollTop ||
      document.body.scrollTop;

    const scaffolds = document.querySelectorAll('zero-scaffold');

    if (scrollTop > 50 !== scrolled) {
      scrolled = scrollTop > 10;
      document.dispatchEvent(
        new CustomEvent('zero-scrolled', {
          detail: {
            scrolled,
          },
          bubbles: true,
          cancelable: true,
        }),
      );
    }

    if (scrollTop > 50) {
      scaffolds.forEach((scaffold) => {
        scaffold.classList.add('scrolled');
      });
    } else {
      scaffolds.forEach((scaffold) => {
        scaffold.classList.remove('scrolled');
      });
    }
  });
}
