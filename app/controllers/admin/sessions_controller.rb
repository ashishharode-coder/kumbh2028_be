module Admin
  class SessionsController < ActionController::Base
    layout "admin"

    def new
    end

    def create
      super_admin = AuthenticationService.authenticate(
        model: SuperAdmin,
        login: params[:email],
        password: params[:password],
        field: :email
      )

      if super_admin
        SessionManager.sign_in(
		  cookies: cookies,
		  request: request,
		  super_admin: super_admin
		)

        redirect_to admin_root_path
      else
        flash.now[:alert] = "Invalid email or password"

        render :new,
               status: :unprocessable_entity
      end
    end

    def destroy
      SessionManager.sign_out(cookies: cookies)

      redirect_to new_admin_session_path
    end
  end
end