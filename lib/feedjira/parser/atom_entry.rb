# rubocop:disable Style/DocumentationMethod
module Feedjira
  module Parser
    # Parser for dealing with Atom feed entries.
    class AtomEntry
      include SAXMachine
      include FeedEntryUtilities

      element :title, as: :title_html,  with: { type: 'html' }
      element :title, as: :title_xhtml, with: { type: 'xhtml' }
      element :title, as: :title_text,  with: { type: 'text' }
      element :title
      element :link, as: :url, value: :href, with: { type: 'text/html', rel: 'alternate' } # rubocop:disable Metrics/LineLength
      element :name, as: :author
      element :content
      element :summary

      element :"media:content", as: :image, value: :url
      element :enclosure, as: :image, value: :href

      element :published
      element :id, as: :entry_id
      element :created, as: :published
      element :issued, as: :published
      element :updated
      element :modified, as: :updated
      elements :category, as: :categories, value: :term
      elements :link, as: :links, value: :href

      def url
        @url ||= links.first
      end

      def title
        title_xhtml || title_html || title_text || @title
      end
    end
  end
end
