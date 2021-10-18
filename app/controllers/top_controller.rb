class TopController < ApplicationController
  def main
    render 'login'
  end

  def login
    logger.debug "---------------"
    user = User.find_by(uid: params[:uid])
    if user and BCrypt::Password.new(user.pass) == params[:pass]
      flash[:notice] = 'ログインできました'
      session[:login_uid] = user.uid
      redirect_to root_path
    else
      flash[:notice] = 'ログインに失敗しました'
      render 'login'
    end
  end

  def logout
    flash[:notice] = 'ログアウトに成功しました'
    session.delete(:login_uid)
    redirect_to root_path
  end
end
