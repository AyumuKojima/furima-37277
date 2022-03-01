const pay = () => {
  Payjp.setPublicKey(ENV["PAYJP_PUBLIC_KEY"]);
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById('charge-form');
    const formData = new FormData(form);

    const card = {
      number: formData.get("order_address[number]"),
      cvc: formData.get("order_address[cvc]"),
      exp_month: formData.get("order_address[exp_month]"),
      exp_year: `20${formData.get("order_address[exp_year]")}`
    };
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const inputHtml = `<input value=${token} name='token' type='hidden'>`;
        form.insertAdjacentHTML('beforeend', inputHtml);
      };

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      form.submit()
    });
  });
};

window.addEventListener("load", pay);