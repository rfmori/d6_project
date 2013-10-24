class PostMessage < ActiveRecord::Base
  self.name = 'tb_post_message'
  belongs_to :post, :foreign_key => 'post_id'
end
