require 'rails_helper'

RSpec.describe FetchLinkCardService do
  subject { FetchLinkCardService.new }

  before do
    stub_request(:head, 'http://example.xn--fiqs8s/').to_return(status: 200, headers: { 'Content-Type' => 'text/html' })
    stub_request(:get, 'http://example.xn--fiqs8s/').to_return(request_fixture('idn.txt'))
    stub_request(:head, 'https://github.com/qbi/WannaCry').to_return(status: 404)
    subject.call(status)
  end

  context 'card preview' do
    context do
      let(:status) { "http://example.xn--fiqs8s/" }

      it 'works with IDN URLs' do
        expect(PreviewCard.all.size).to be == 1
        expect(a_request(:get, 'http://example.xn--fiqs8s/')).to have_been_made.at_least_once
      end
    end
  end

end
