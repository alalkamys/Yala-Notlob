import axios from "axios";

document.addEventListener("turbolinks:load", () => {
  // // Getting HTML elements
  const bellLink = document.querySelector("#billDropdownMenuLink");
  const bellIcon = document.querySelector("#bell");

  // // Checking if elements exist (in case user is not sihned in)
  // if(bellLink && bellIcon){
  // Adding event listner on the bell
  bellLink.addEventListener("click", async (e) => {
    console.log("clicked22222222222222222");
    // Checking if there are new notifications
    if (bellIcon.style.color === "purple") {
      // Removing the red color
      bellIcon.style.color = null;
      // Getting the token that will be send in the axios patch request
      const csrf = document
        .querySelector("meta[name='csrf-token']")
        .getAttribute("content");
      // Looping on every notification to update its status to viewd
      const notificationsElement = document.querySelector(
        ".notifications-container"
      );
      for (const notificationElement of notificationsElement.children) {
        if (notificationElement.getAttribute("data-seen") === "false") {
          console.log("Updating status to seen via Ajax request");
          // Prerparing data fox axios patch call
          const notification_id = notificationElement.getAttribute("data-id");
          const body = { authenticity_token: csrf };
          try {
            const res = await axios.patch(
              `/notifications/${notification_id}`,
              body
            );
            notificationElement.setAttribute("data-seen", true);
            console.log(res);
          } catch (err) {
            console.log(err);
          }
        }
      }
    }
  });
  // }
});
