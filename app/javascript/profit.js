function caliculateProfit (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup",() => {
    const priceVal = itemPrice.value;
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.ceil(priceVal * 0.9);
  });
}

addEventListener('load', caliculateProfit);
