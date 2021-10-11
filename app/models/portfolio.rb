class Portfolio < ApplicationRecord
has_many:technologies
accepts_nested_attributes_for :technologies, 
                reject_if: lambda {|attrs|attrs['name'].blank?}
                
include Placeholder

    validates_presence_of :title, :body, :main_image, :thumg_image

    #1st way to fing specific records with subtitle ANGULAR
    def self.angular
        where(subtitle:"Angular")
    end

    #2nd way to fing specific records with subtitle ANGULAR
    scope :ruby_on_rails_portfolios, ->{where(subtitle:"Ruby on Rails")}


    after_initialize :set_defaults

    def set_defaults
        self.main_image ||=Placeholder.image_generator(height:'600', width: '400')   
        self.thumg_image ||=Placeholder.image_generator(height:'350', width: '150')   
    end

    resourcify
    has_many :users, through: :roles, class_name: 'User', source: :users
    has_many :creators, -> { where(roles: {name: :creator}) }, through: :roles, class_name: 'User', source: :users 
    has_many :editors, -> { where(roles: {name: :editor}) }, through: :roles, class_name: 'User', source: :users 


end
