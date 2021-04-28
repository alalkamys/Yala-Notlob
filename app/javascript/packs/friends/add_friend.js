import axios from "axios";

$(document).ready(function () {
  // Getting HTML elements
  const addBtn = document.querySelector("#friends-add-btn");
  const friendsContainer = $("#friends-container");

  addBtn.addEventListener("click", async (e) => {
    e.preventDefault();

    // Getting the token that will be send in the axios patch request
    const csrf = document
      .querySelector("meta[name='csrf-token']")
      .getAttribute("content");
    const email = document.querySelector("#email").value;
    console.log(email);

    const MAIL_FORMAT = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (email && email.match(MAIL_FORMAT)) {
      console.log("Updating status to seen via Ajax request");

      // Preparing data fox axios patch call
      const body = { authenticity_token: csrf, email: email };
      try {
        const res = await axios.post(`/friends`, body);
        const data = res.data;

        console.log(data);

        if (data.success) {
          const newFriend = data.new_friend;
          let newFriendElement = `<div id="friend-${newFriend.id}" class="col-md-4">
                                                    <div class="row" style="top:0%, left:0%">
                                                    <div class="card mx-5 my-3">
                                                        <div class="card-body">
                                                        <div class="col-md-6">
                                                        <img src="${newFriend.image}", style= "height:120px;width:120;" >
                                                        </div>
                                                        <div class="col-md-12">
                                                            <br>
                                                            <h4>
                                                            <div class="badge badge-light"> ${newFriend.full_name}</div>
                                                            </h4>
                                                            <hr/>
                                                            <div class="btn btn-danger btn-sm"> <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-x" viewBox="0 0 16 16"><path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/><path fill-rule="evenodd" d="M12.146 5.146a.5.5 0 0 1 .708 0L14 6.293l1.146-1.147a.5.5 0 0 1 .708.708L14.707 7l1.147 1.146a.5.5 0 0 1-.708.708L14 7.707l-1.146 1.147a.5.5 0 0 1-.708-.708L13.293 7l-1.147-1.146a.5.5 0 0 1 0-.708z"/></svg>
                                                            <a style="color: white" data-remote="true" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/friends/${newFriend.id}">unfriend</a>
                                                            </div>
                                                        </div>
                                                        </div>
                                                    </div>
                                                    </div>
                                                </div>`;

          $("#email").val("");
          friendsContainer.prepend(newFriendElement);
          $(`#friend-${newFriend.id}`).hide().fadeIn(1000);

          $(`<div class="text-center alert alert-success" style="margin-top: 10px; font-size: medium;">
             <button type="button" class="close" data-dismiss="alert">&times;</button>
             You have successfully added ${newFriend.full_name}  
          </div>`).insertAfter("#email");
        } else {
          const errors = data.errors;
          $(`<div class="error text-center alert alert-danger" style="margin-top: 10px; font-size: medium;">
             <button type="button" class="close" data-dismiss="alert">&times;</button>
             ${errors}
          </div>`).insertAfter("#email");
        }
      } catch (err) {
        console.log(err);
      }
    } else if (!email) {
      $(`<div class="error text-center alert alert-danger" style="margin-top: 10px; font-size: medium;">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            No email was given
          </div>`).insertAfter("#email");
    } else {
      $(`<div class="error text-center alert alert-danger" style="margin-top: 10px; font-size: medium;">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            Please enter a valid email 
        </div>`).insertAfter("#email");
    }
  });
});
