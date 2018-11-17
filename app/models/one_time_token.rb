class OneTimeToken < ApplicationRecord
    # enum type: {invite_lab: 0}
    self.inheritance_column = :_type_disabled
end
