require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  #(1)setupメソッドを定義する。
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end
　
  #(2)パスワード再設定のテストを行う。
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    #(3)まずは無効なメールアドレスで、パスワード再設定用のメール送信をPasswordResetsリソースのcreateアクションへPOSTリクエストを送信させる記述を行う
    post password_resets_path, params: { password_reset: { email: "無効なメアド" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    #(4)今度は有効なメールアドレスで、パスワード再設定用のメール送信をPasswordResetsリソースのcreateアクションへPOSTリクエストを送信させる記述を行う。
    post password_resets_path,
       params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    #(5)パスワード再設定フォームのテストを行う。
    user = assigns(:user)
    #(6)無効なメールアドレスで、パスワード再設定フォームへGETリクエストを送信させる記述を行う。
    get edit_password_reset_path(user.reset_token, email: "無効なメアド")
    assert_redirected_to root_url
    #(7)ここでユーザーを無効なユーザーに切り替える処理を記述（攻撃者によるアカウント乗っ取りのテスト）。
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    #(8)そして今度は有効なユーザーで(トークンは無効)。
    user.toggle!(:activated)
    get edit_password_reset_path('無効なトークン', email: user.email)
    assert_redirected_to root_url
    #(9)有効なメールアドレスとトークンで、パスワード再設定フォームヘGETリクエストを送信させる記述を行う。
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    #(10)無効なパスワードとパスワード確認を、PasswordResetsコントローラのupdateアクションヘPATCHリクエストを送信してしまった場合の記述をする。
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "無効なパス",
                        password_confirmation: "無効なパス確認" } }
    assert_select 'div#error_explanation'
    #(11)パスワードとパスワード確認入力が空のまま、PasswordResetsコントローラのupdateアクションヘPATCHリクエストを送信してしまった場合の記述をする。
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "",
                        password_confirmation: "" } }
    assert_select 'div#error_explanation'
    #(12)有効なパスワードとパスワード確認入力で、PasswordResetsコントローラのupdateアクションヘPATCHリクエストが送信された場合の記述をする。
    patch password_reset_path(user.reset_token),
      params: { email: user.email,
                user: { password:              "有効なパス",
                        password_confirmation: "有効なパス確認" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
