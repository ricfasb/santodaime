class Email < ApplicationRecord
  extend Enumerize

  enumerize :email_type, in: [:intern, :extern]

  belongs_to :company
  belongs_to :person
end
