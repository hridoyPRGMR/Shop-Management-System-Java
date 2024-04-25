document.addEventListener('DOMContentLoaded', function () {
    const categoryItems = document.querySelectorAll("#categoryItem");

    categoryItems.forEach(function (item) {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            const category = document.getElementById('category'); // Corrected ID name
            const name = item.textContent;
            category.innerText = name;

            const value = item.getAttribute('value');
            console.log(value);

        });
    });
});