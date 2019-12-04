class Users::RegistrationsController < ApplicationController
  def create
    user_params = params.require(:user).permit(:name, :password, :password_confirmation)

    user = UserRegister.new(user_params).register_user

    if user.valid?
      render_json(201, user: user.as_json(only: [:id, :name, :token]))
    else
      render_json(422, user: user.errors.as_json)
    end
  rescue ActionController::ParameterMissing => e
    render_json(400, error: e.message)
  end
end
