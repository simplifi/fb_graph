module FbGraph
  module Connections
    module AdImages
      def ad_images(options = {})
        ad_images = self.connection :adimages, options
        ad_images.map! do |ad_image|
          AdImage.new ad_image[:id], ad_image.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def ad_image!(options = {})
        ad_image = post options.merge(:connection => :adimages)

        ad_image_id = ad_image[:id]

        merged_attrs = options.merge(
          :access_token => options[:access_token] || self.access_token
        )

        if options[:redownload]
          merged_attrs = merged_attrs.merge(ad_image[:data][:adimages][ad_image_id]).with_indifferent_access
        end

        AdImage.new ad_image_id, merged_attrs
      end
    end
  end
end
