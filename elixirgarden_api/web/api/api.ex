
defmodule ElixirgardenApi.API.Router.V1 do
  use Maru.Router

  get do
     conn |> text("API works Swagger!")
 end
  resource :user do
    # desc "description"
    get do
      text(conn, "Router: v1")
    end
    # desc "description"
    params do
      requires :name, type: String
    end
    post do
      text(conn, "Router: v1 Post")
    end
  end

end

defmodule ElixirgardenApi.API do
  use Maru.Router
  plug Plug.RequestId
  plug Plug.Logger
  resources do
     mount ElixirgardenApi.API.Router.V1
   end

  if Mix.env == :dev do
    plug MaruSwagger,
      at:      "/swagger",
      for:     ElixirgardenApi.API,
      pretty:  true
  end

  rescue_from Unauthorized, as: e do
   IO.inspect e
   status 401
   "Unauthorized"
  end

  rescue_from :all, as: e do
   IO.inspect e
   status 500
   "Server Error"
  end

  get do
     conn |> text("API works!")
 end




end






#
#
# defmodule ElixirgardenApi.API do
#   use Maru.Router
#
#         rescue_from :all, as: e do
#           IO.inspect e
#
#         conn
#         |> put_status(500)
#         |> text("Server Error")
#       end
#
#   if Mix.env == :dev do
#     plug MaruSwagger,
#      at: "/swagger/v1",
#     pretty: true
#   end
#
#   get :hello do
#     text(conn, "API works!")
#   end
#
#   #mount ElixirgardenApi.API.V1
#
# end
#
#
# defmodule ElixirgardenApi.API.V1 do
#   use Maru.Router
#     desc "login"
#   params do
#    requires :user_name, type: String
#    requires :password, type: String
#   end
#     get :user do
#         %{ hello: :world }
#     end
#
#     get do
#       %{ hello: :world2 }
#     end
#
# end
