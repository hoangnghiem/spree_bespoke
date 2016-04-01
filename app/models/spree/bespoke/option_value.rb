class Spree::Bespoke::OptionValue < ActiveRecord::Base
  belongs_to :option_type, class_name: 'Spree::Bespoke::OptionType', foreign_key: 'option_type_id'
  acts_as_list scope: :option_type

  Paperclip.interpolates :option_type_id do |attachment, style|
    attachment.instance.option_type.id
  end

  has_attached_file :image,
                    url: '/spree/bespoke/option_type/:option_type_id/option_value/:id/:basename.:extension',
                    path: ':rails_root/public/spree/bespoke/option_type/:option_type_id/option_value/:id/:basename.:extension'

  validates_attachment :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

  validates :name, presence: true
  
end
