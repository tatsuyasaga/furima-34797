function caliculateTax (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup",() => {
    const priceVal = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = Math.floor(priceVal * 0.1);
  });
}

addEventListener('load', caliculateTax);

