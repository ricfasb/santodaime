class ProfilePermission < ApplicationRecord
  belongs_to :profile
  belongs_to :permission
end
