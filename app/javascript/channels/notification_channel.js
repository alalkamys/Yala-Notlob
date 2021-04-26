import consumer from "./consumer"



// document.addEventListener('turbolinks:load', () =>{

//   const userContainer = document.getElementById('user-id');
//   const user_id = userContainer.getAttribute('data-user-id');
 


//   consumer.subscriptions.create({channel: "NotificationChannel", 
//   user_id: user_id},{

//     connected() {
  
//       console.log("connected by user-id -> " + user_id);
//       // Called when the subscription is ready for use on the server
//     },
  
//     disconnected() {
//       // Called when the subscription has been terminated by the server
//     },
  
//     received(data) {
//       console.log(data);
//       // Called when there's incoming data on the websocket for this channel
//     }
//   });
  

// })

document.addEventListener('turbolinks:load', ()=>{

  // Getting id of user to establish a connection
  
  const userContainer = document.getElementById('user-id');
  if (userContainer){
    const user_id = userContainer.getAttribute('data-user-id');
    // We check to see of connection exists, if so we don't create a new connection
    const subscriptions = consumer.subscriptions.subscriptions;
    let notificationChannel = subscriptions.find((subscriptionsObject)=>{
      const identifierObj = JSON.parse(subscriptionsObject.identifier);
      return identifierObj.channel === "NotificationChannel"
    });
    
    // Establishing a connection channedl if a connection hasn't already been established
    if(!notificationChannel){
  
      consumer.subscriptions.create({ channel: "NotificationChannel", user_id: user_id }, {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log("Connected to notification channel " + user_id);
        },
      
        disconnected() {
          // Called when the subscription has been terminated by the server
        },
      
        received(data) {   // Data is the notification recived
          // Called when there's incoming data on the websocket for this channel
          console.log(data);
          const notificationsElement = document.querySelector(".notifications-container");
          const bellIcon = document.querySelector("#bell");
          const noNewNotificationElement = document.querySelector("#no-new-notification");
          bellIcon.style.color = "purple";
          if(noNewNotificationElement){
            noNewNotificationElement.style.display = "none"; 
          }
          let newNotification = "";
          let oldNotifications = notificationsElement.innerHTML;
          if(data.notification_type === "invitation"){  
            newNotification = `<a class="dropdown-item font-weight-bold" href='/orders/${data.order.id}' data-seen="false" data-id="${data.notification_id}"> ${data.sender.full_name}
                                  Has Invited You to His Order</a>`
            newNotification += `<div class="dropdown-divider"></div>`;
          }else{  // Accept
            newNotification = `<a class="dropdown-item font-weight-bold" href="/orders/${data.order.id}" data-seen="false" data-id="${data.notification_id}"> ${data.sender.full_name}
                                Joined Your ${data.order.mealtype}</a>`
            newNotification += `<div class="dropdown-divider"></div>`;
          }
          notificationsElement.innerHTML = newNotification + oldNotifications;
        }
      });
    }
  }
});

