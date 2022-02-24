window.up = id => {
    quantity = document.getElementById(id)
    quantity.innerHTML = ++quantity.attributes[1].value;
}

window.down = id => {
    quantity = document.getElementById(id)
    if (quantity.attributes[1].value == 1) $(`#${id}`).attr("disabled", true);
    else quantity.innerHTML = --quantity.attributes[1].value;
}

window.get_url = id => {
    values = document.getElementsByClassName(`${id}`);
    quantity = $(`#${id}`).attr("value")
    name = $(values.item(0)).attr("value")
    price = $(values.item(1)).attr("value")
    url = `/select?name=${name}&quantity=${quantity}&price=${price}`
    $(".select").attr("href", url)
}
