module DefaultPageTitle
    extend ActiveSupport::Concern

    included do
     before_action :set_title
    end

    def set_title
        @page_title= "Main Page | My Portfolio Website"
        @seo_keywords="Noman Ajmal Portfolio"
    end
end
