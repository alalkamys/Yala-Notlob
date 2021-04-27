document
  .getElementById("member")
  .addEventListener("keyup", () =>
    document.getElementsByTagName("form")[1].submit()
  );
