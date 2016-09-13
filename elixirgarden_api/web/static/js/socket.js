// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

//Scheduling channel
let scheduleChannel = socket.channel('schedule_channel:lobby', {})
let scheduleInput = $('.schedule-text')
let scheduleButton = $('.schedule-button')

scheduleInput.on()

//Output to nodes
// Now that you are connected, you can join channels with a topic:
let outputNodeChannel = socket.channel("output_node_room:lobby", {})
let outputNodeInput = $(".output-node-text")
let outputNodeContainer = $(".output-node")



outputNodeInput.on("keypress", event => {
  if(event.keyCode === 13){
    let submittedField = event.currentTarget.id
    let node_id_re = /output-node-(\d+)/;
    let node_id_matches = node_id_re.exec(submittedField)
    let node_id_val = node_id_matches[1]
    console.log(node_id_val);

    let submittedFieldId = "#" + submittedField
    let submittedFieldInput = $(submittedFieldId)

    let new_output_msg_body = new Object
    new_output_msg_body.node_id =  node_id_val
    new_output_msg_body.node_value = submittedFieldInput.val()

    let jsonified_msg = JSON.stringify(new_output_msg_body)
    //sends out the actual message
    outputNodeChannel.push("new_output_msg", {
      body: jsonified_msg
    })
    //clears the field that just typed that stuff in
    submittedFieldInput.val("")
    console.log("Enter was pressed");
  }
})

outputNodeChannel.on("new_output_msg", payload => {
  let message_object = JSON.parse(payload.body)
  outputNodeContainer.html("")
  outputNodeContainer.append( `<br/>[${Date()}] Node Id: ${message_object.node_id} Value: ${message_object.node_value}` )
  console.log("Message Ack");
  console.log("payload, %o", payload);
})

outputNodeChannel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
