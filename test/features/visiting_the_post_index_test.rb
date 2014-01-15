require "test_helper"

feature "Visiting the Post Index" do
	scenario "with existing posts" do
		#given existing posts (in fixtures)
		#
		##when i visit /posts
		visits posts_path

		#then the existing posts should be loaded
		page.text.must_include posts(:cf).title
  	end
end
