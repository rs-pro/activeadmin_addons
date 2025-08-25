# ActiveAdmin Addons
[![Gem Version](https://badge.fury.io/rb/activeadmin_addons.svg)](https://badge.fury.io/rb/activeadmin_addons)
[![NPM Version](https://img.shields.io/npm/v/@platanus/activeadmin_addons.svg)](https://www.npmjs.com/package/@platanus/activeadmin_addons)
[![CI](https://github.com/platanus/activeadmin_addons/actions/workflows/ci.yml/badge.svg)](https://github.com/platanus/activeadmin_addons/actions/workflows/ci.yml)

ActiveAdmin Addons will extend your ActiveAdmin and enable a set of addons you can optionally use to improve the ActiveAdmin UI and make it awesome.

## 🚀 ActiveAdmin 4 Support

This gem now supports ActiveAdmin 4! The latest beta version includes:
- Support for modern JavaScript bundlers (esbuild, webpack, importmap)
- ESM module support for better tree-shaking
- Updated CSS selectors for ActiveAdmin 4 compatibility
- NPM package available for easier JavaScript management

## What you get:

#### Rows/Columns

- [Shrine Image](#shrine-image): show thumbnails on your show/index views.
- [AASM Integration](#aasm-integration): nice looking tags for states.
- [Rails Enum Integration](#rails-enum-integration): nice looking tags for enums.
- [Boolean Values](#boolean-values): beautiful boolean values.
- [Toggleable Booleans](#toggleable-boolean-columns): have switches to toggle values directly at the index
- [Number Formatting](#number-formatting): format you currencies with ease.
- [List](#list): show Arrays or Hashes like a list.

#### Inputs

- [Select2 Input](#select2-input): cool select boxes for everyone.
- [Tag Input](#tag-input): to add tags using select2.
- [Search Select Input](#search-select-input): easy ajax search with activeadmin.
- [Selected List Input](#selected-list-input): to handle your many to many associations.
- [Nested Select Input](#nested-select-input): to build related select inputs.
- [Color Picker Input](#color-picker-input): select colors from a pretty popup.
- [Date Time Picker Input](#date-time-picker-input): pick date and time comfortably.

#### Filters

- [Numeric Range Filter](#numeric-range-filter): filter your results using a numeric range (i.e. age between 18-30).
- [Date Time Picker Filter](#date-time-picker-filter): filter your results using a datetime range.
- [Search Select Filter](#search-select-filter): filter your results using the ajax select input.

#### Themes
- [No Theme](#no-theme): ActiveAdmin default style.

## Installation

### Requirements

- Ruby >= 3.2
- Rails >= 7.0
- ActiveAdmin >= 3.0 (ActiveAdmin 4 supported!)

### For ActiveAdmin 4

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin_addons', '~> 2.0.0.beta'
```

And then execute:

```bash
$ bundle
```

After that, run the generator with your preferred bundler:

```bash
# Auto-detect your bundler (recommended)
$ rails g activeadmin_addons:install

# Or specify explicitly:
$ rails g activeadmin_addons:install --bundler=esbuild
$ rails g activeadmin_addons:install --bundler=importmap
$ rails g activeadmin_addons:install --bundler=webpack
$ rails g activeadmin_addons:install --bundler=sprockets
```

#### Using NPM Package (Optional)

For better JavaScript module management, you can also install via NPM:

```bash
npm install @platanus/activeadmin_addons
```

Then import in your `active_admin.js`:

```javascript
import '@platanus/activeadmin_addons';
```

### For ActiveAdmin 3 (Legacy)

For ActiveAdmin 3.x, use version 1.x of this gem:

```ruby
gem 'activeadmin_addons', '~> 1.0'
```

Check [here](docs/install_generator.md) to see more information about the generator.

## Migrating from ActiveAdmin 3 to 4

If you're upgrading from ActiveAdmin 3 to 4, please note:

1. **Update your Gemfile**: Use version 2.x of activeadmin_addons
2. **Run the installer again**: The asset pipeline has changed significantly
3. **CSS Selectors**: Some CSS classes have changed (e.g., `.filter_form` → `.filters-form`)
4. **JavaScript modules**: Consider switching to the NPM package for better module management

For detailed migration instructions, see [ActiveAdmin 4 Migration Guide](docs/activeadmin-4-gem-updates.md).

## Default changes to behaviour

Installing this gem will enable the following changes by default:

* The default date input will be `:datepicker` instead of `:date_select`
* Select filters will show translated values when used with Rails built-in `enums`
* All select boxes will use Slim Select (replacing Select2 in v2.x)

## Addons

### Rows/Columns

#### Images

Display images in the index and show views. This implementation supports [Shrine](https://github.com/shrinerb/shrine).

<img src="./docs/images/paperclip-image-column.png" height="380" />

[Read more!](docs/images.md)

#### AASM Integration

You can show [aasm](https://github.com/aasm/aasm) values as active admin tags.

<img src="./docs/images/aasm-integration-row.png" height="150" />

[Read more!](docs/aasm_integration.md)

#### Rails Enum Integration

You can show Rails' built in `enums` as active admin tags.

<img src="./docs/images/enumerize-tag-column.png" height="250" />

[Read more!](docs/enum_integration.md)

#### Boolean Values

Modifies how boolean values are displayed.

<img src="./docs/images/bool-column.png" height="250" />

[Read more!](docs/boolean_values.md)

#### Toggleable Boolean Columns

Have switches to toggle values directly at the index

<img src="./docs/images/toggle-bool-column.gif" height="250" />

[Read more!](docs/toggle_bool.md)

#### Number Formatting

You can show numbers with format supported by [Rails NumberHelper](http://apidock.com/rails/v4.2.1/ActionView/Helpers/NumberHelper)

<img src="./docs/images/number-column.png" height="250" />

[Read more!](docs/number-formatting.md)

#### List

You can show `Array` or `Hash` values as html lists.

<img src="./docs/images/list-row.png" height="250" />

[Read more!](docs/list.md)

#### Markdown

You can render text as markdown.

<img src="./docs/images/markdown-row.png" height="250" />

[Read more!](docs/markdown.md)

### Inputs

#### Slim Select Input

With [Slim Select](https://slimselectjs.com/) the select control looks nicer, it works great with large collections.

<img src="./docs/images/slim-select.gif" />

[Read more!](docs/slim-select_default.md)

#### Tag Input

Using tags input, you can add tags using slim select.

<img src="./docs/images/slim-select-tags.gif" />

[Read more!](docs/slim-select_tags.md)

#### Selected List Input

This form control allows you to handle your many to many associations.

<img src="./docs/images/slim-select-selected-list.gif" />

[Read more!](docs/slim-select_selected_list.md)

#### Search Select Input

Using `search_select` input, you can easily add ajax search to activeadmin.

<img src="./docs/images/slim-select-search-select.gif" />

[Read more!](docs/slim-select_search.md)

#### Nested Select Input

Using `nested_select` input, you can build related select inputs.

<img src="./docs/images/slim-select-nested-select.gif" />

[Read more!](docs/slim-select_nested_select.md)

### Color Picker Input

You can pick colors using [JQuery Palette Color Picker](https://github.com/carloscabo/jquery-palette-color-picker)

```ruby
f.input :color, as: :color_picker
```

<img src="./docs/images/color-picker.gif" height="280" />

[Read more!](docs/color-picker.md)

### Date Time Picker Input

You can pick dates with time using the xdan's [jQuery Plugin Date and Time Picker](https://github.com/xdan/datetimepicker)

```ruby
f.input :updated_at, as: :date_time_picker
```

<img src="./docs/images/date-time-picker.gif" height="280" />

[Read more!](docs/date-time-picker.md)

### Filters

#### Numeric Range Filter

To filter based on a range of values you can use `numeric_range_filter` like this:

```ruby
filter :number, as: :numeric_range_filter
```

<img src="./docs/images/filter-range.png" height="150" />

#### Date Time Picker Filter

To filter based on a range of datetimes you can use `date_time_picker_filter` like this:

```ruby
filter :created_at, as: :date_time_picker_filter
```

<img src="./docs/images/data-time-picker-range.png" height="150" />

#### Search Select Filter

You can use the ajax select input to filter values on index view like this:

```ruby
filter :category, as: :search_select_filter
```

<img src="./docs/images/filter-search-select.png" height="160" />

[Read more!](docs/slim-select_search.md#filter-usage)

### Themes

#### NO Theme
Use default active_admin theme.

## Publishing

### Publishing a New Version

On a new branch:

1. Change `VERSION` in `lib/activeadmin_addons/version.rb`. Note that beta versions should have a `.beta` suffix (e.g. `2.0.0.beta.5`).
2. Change `"version"` in `package.json` to the same version. Note that beta versions should have a `-beta` suffix (e.g. `2.0.0-beta.5`).
3. Change `Unreleased` title to current version in `CHANGELOG.md`.
4. Run `bundle install`.
5. Open a new PR with those changes.
6. Once the PR is merged, checkout to master and pull the changes.
7. Create tag. For example: `git tag v2.0.0.beta.5`.
8. Push tag. For example: `git push origin v2.0.0.beta.5`.

### Automated Publishing

The GitHub Actions workflow will automatically:
- Publish the Ruby gem to RubyGems (requires `RUBYGEMS_API_KEY` secret)
- Publish the NPM package to npm registry (requires `NPM_TOKEN` secret)

### Manual Publishing

If needed, you can publish manually:

```bash
# Ruby Gem
gem build activeadmin_addons.gemspec
gem push activeadmin_addons-2.0.0.beta.5.gem

# NPM Package
npm run prepublishOnly
npm publish --access public
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you want to collaborate, please check [the rules](docs/CONTRIBUTING.md) first.

## Credits

Thank you [contributors](https://github.com/platanus/activeadmin_addons/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

activeadmin_addons is maintained by [platanus](http://platan.us).

## License

ActiveAdminAddons is © 2021 Platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
