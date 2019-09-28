# frozen_string_literal: true

describe 'meta', chdir: false do
  it 'is covered by specs' do
    regular_files = Dir['lib/nanoc/core/**/*.rb']
    regular_file_base_names = regular_files.map { |fn| fn.gsub(/^lib\/nanoc\/core\/|\.rb$/, '') }

    spec_files = Dir['spec/nanoc/core/**/*_spec.rb']
    spec_file_base_names = spec_files.map { |fn| fn.gsub(/^spec\/nanoc\/core\/|_spec\.rb$/, '') }

    # TODO: don’t ignore anything
    ignored = %w[
      action_provider
      assertions
      basic_item_view
      checksum_collection
      compilation_context
      contracts_support
      dependency
      document_view_mixin
      error
      errors
      identifiable_collection_view
      item_collection
      item_rep_repo
      layout_collection
      mutable_document_view_mixin
      mutable_identifiable_collection_view
      outdatedness_reasons
      outdatedness_rule
      post_compile_item_collection_view
      processing_actions
      snapshot_def
      version
      view
      view_context_for_compilation
      view_context_for_pre_compilation
      view_context_for_shell
    ]

    expect(regular_file_base_names - ignored).to match_array(spec_file_base_names)
  end

  it 'doesn’t log anything' do
    # TODO: don’t have any exceptions
    regular_files = Dir['lib/nanoc/core/**/*.rb'] - ['lib/nanoc/core/data_source.rb']

    expect(regular_files).to all(satisfy do |fn|
      content = File.read(fn)
      !content.match?(/\b(puts|warn)\b/) && !content.match?(/\$std(err|out)/)
    end)
  end
end