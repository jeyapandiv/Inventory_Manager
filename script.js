//event listener - when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", () => {
  fetchInventory();
  fetchRecipientDetails();
});

//show popup by id
function showPopup(popupId) {
  let popupShower = document.getElementById(popupId);
  popupShower.style.display = "flex";
}

//close popup by id
function closePopup(popupId) {
  let popupHider = document.getElementById(popupId);
  popupHider.style.display = "none";
}

//fetching inventory data from db
function fetchInventory() {
  fetch("get_inventory.php")
    .then((response) => response.json())
    .then((data) => {
      updateCards(data.topProducts);
      updateChart(data.inventoryStatus);
    });
}

//fetching recipient details from db
function fetchRecipientDetails() {
  fetch("get_recipient_details.php")
    .then((response) => response.json())
    .then((data) => {
      updateRecipientTable(data);
    });
}

//updating product cards - new data
function updateCards(products) {
  products.forEach((product, index) => {
    document.getElementById(
      `card-${index + 1}`
    ).textContent = `${product.productName} : ${product.quantity}`;
  });
}

let chartInstance = null;

//array of colors
const barColors = [
  "#4CAF50",
  "#3E92CC",
  "#8E44AD",
  "#FF7F11",
  "#D1009B",
  "#FF0F00",
  "#4ADBC8",
];

function updateChart(inventoryStatus) {
  const ctx = document.getElementById("inventoryChart").getContext("2d");

  //destroying existing chart if exists
  if (chartInstance) {
    chartInstance.destroy();
  }

  //generating colors dynamically
  const colors = inventoryStatus.map(
    (_, index) => barColors[index % barColors.length]
  );

  //creating new chart instance
  chartInstance = new Chart(ctx, {
    type: "bar",
    data: {
      labels: inventoryStatus.map((item) => item.productName),
      datasets: [
        {
          label: "Quantity",
          data: inventoryStatus.map((item) => item.quantity),
          backgroundColor: colors,
        },
      ],
    },
    options: {
      responsive: true,
      scales: {
        x: {
          ticks: {
            color: "#333",
            font: {
              size: 14,
              weight: "bold",
            },
            padding: 10,
          },
          grid: {
            display: false,
          },
        },
        y: {
          beginAtZero: true,
        },
      },
    },
  });
}

//updating recipient detail table - new data
function updateRecipientTable(data) {
  const tableBody = document.querySelector("#recipientTable tbody");
  tableBody.innerHTML = "";

  data.forEach((item) => {
    const row = document.createElement("tr");
    row.innerHTML = `
            <td>${item.product}</td>
            <td>${item.recipient}</td>
            <td>${item.quantity}</td>
            <td>${item.update_time}</td>
        `;
    tableBody.appendChild(row);
  });
}

//add new product - form submission
function addProduct(event) {
  event.preventDefault();
  const formData = new FormData(event.target);

  fetch("add_product.php", {
    method: "POST",
    body: formData,
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      return response.text();
    })
    .then((result) => {
      if (result.trim() === "Success") {
        fetchInventory(); //refresh inventory list
        closePopup("add-popup");
      } else {
        alert(result);
      }
    })
    .catch((error) => {
      console.error(
        "There has been a problem with your fetch operation:",
        error
      );
    });

  let form = event.target; //geting form that triggered the event
  form.reset();
}

//update inventory data - form submission
function updateInventory(event) {
  event.preventDefault();
  const formData = new FormData(event.target);

  fetch("update_inventory.php", {
    method: "POST",
    body: formData,
  })
    .then((response) => response.text())
    .then((result) => {
      if (result === "Success") {
        fetchInventory();
        fetchRecipientDetails(); //refresh recipient details
        closePopup("update-popup");
      } else {
        alert(result);
      }
    });

  let form = event.target; //geting form that triggered the event
  form.reset();
}
