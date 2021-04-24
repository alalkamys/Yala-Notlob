import consumer from "./consumer"



document.addEventListener('turbolinks:load', () =>{

  const userContainer = document.getElementById('user-id');
  const user_id = userContainer.getAttribute('data-user-id');
 


  consumer.subscriptions.create({channel: "NotificationChannel", 
  user_id: user_id},{

    connected() {
  
      console.log("connected by user-id -> " + user_id);
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      console.log(data);
      // Called when there's incoming data on the websocket for this channel
    }
  });
  

})


