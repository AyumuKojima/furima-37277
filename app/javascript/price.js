const price = () => {
  const form = document.getElementById('item-price');
  form.addEventListener('keyup', () => {
    if (!isNaN(form.value)) {
      const commission = form.value / 10;
      document.getElementById("add-tax-price").innerHTML = parseInt(commission, 10);
      document.getElementById("profit").innerHTML = parseInt(form.value - commission, 10);
    };
  });
};

window.addEventListener('load', price);