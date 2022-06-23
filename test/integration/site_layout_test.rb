require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # # 一応、こういうことよね
  # self.test("layout links") { self.get(root_path); self.assert_template("static_pages/home"); self.assert_select("a[href=?]", root_path, count: 2) }
  # self.test("layout links") {
  #   self.get(root_path)
  #   self.assert_template("static_pages/home")
  #   self.assert_select("a[href=?]", root_path, count: 2)
  # }

  # home画面を作成するには、partialを読んだりしているので、それを横断的にテストする
  test "layout links" do
    get root_path
    assert_template "static_pages/home"
    # 5個のリンクの存在確認
    # ?に*_pathを補完している
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get contact_path
    assert_select "title", full_title("Contact")
  end
end
