class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers, dependent: :destroy
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 5 }
	serialize :similar_ids, Array

	include PgSearch
	pg_search_scope :search,
									against: {:title => 'A', :body => 'B'},
									using: {tsearch: {any_word: true, dictionary: 'english'}},
									associated_against: {user: :email}

	pg_search_scope :similar,
									against: {:title => 'A', :body => 'B'},
									using: {tsearch: {any_word: true, dictionary: 'english'}}

	def self.search_text(query)
		if query.present?
			search(query)
		else
			all
		end
	end

	def self.search_similar(query)
		if query.present?
			similar(query)
		end
	end

=begin
	def self.search_text(query)
		if query.present?
			where("title @@ :q or body @@ :q", q: query)
		else
			all
		end
	end
=end

end
