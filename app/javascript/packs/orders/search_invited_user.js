const searchTextField = document.querySelector("#user");
const membersSearchResultsDiv = document.querySelector("#search-results");

searchTextField.addEventListener("keyup", () => {
  if (searchTextField.value == "") {
    membersSearchResultsDiv.innerHTML = "";
  } else {
    console.log(searchTextField.value);
    document.getElementById("btn-img").click();
  }
});
