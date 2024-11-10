# Retrieve the theme settings
export def main [] {
    return {
        binary: '#D1AFE2'
        block: '#A9BCF2'
        cell-path: '#CED0BA'
        closure: '#82CFC0'
        custom: '#DEE0CA'
        duration: '#D2BC82'
        float: '#EAA9BB'
        glob: '#DEE0CA'
        int: '#D1AFE2'
        list: '#82CFC0'
        nothing: '#EAA9BB'
        range: '#D2BC82'
        record: '#82CFC0'
        string: '#A8CA96'

        bool: {|| if $in { '#82CFC0' } else { '#D2BC82' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#EAA9BB' attr: 'b' }
            } else if $in < 6hr {
                '#EAA9BB'
            } else if $in < 1day {
                '#D2BC82'
            } else if $in < 3day {
                '#A8CA96'
            } else if $in < 1wk {
                { fg: '#A8CA96' attr: 'b' }
            } else if $in < 6wk {
                '#82CFC0'
            } else if $in < 52wk {
                '#A9BCF2'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#CED0BA'
            } else if $e < 1mb {
                '#82CFC0'
            } else {{ fg: '#A9BCF2' }}
        }

        shape_and: { fg: '#D1AFE2' attr: 'b' }
        shape_binary: { fg: '#D1AFE2' attr: 'b' }
        shape_block: { fg: '#A9BCF2' attr: 'b' }
        shape_bool: '#82CFC0'
        shape_closure: { fg: '#82CFC0' attr: 'b' }
        shape_custom: '#A8CA96'
        shape_datetime: { fg: '#82CFC0' attr: 'b' }
        shape_directory: '#82CFC0'
        shape_external: '#82CFC0'
        shape_external_resolved: '#82CFC0'
        shape_externalarg: { fg: '#A8CA96' attr: 'b' }
        shape_filepath: '#82CFC0'
        shape_flag: { fg: '#A9BCF2' attr: 'b' }
        shape_float: { fg: '#EAA9BB' attr: 'b' }
        shape_garbage: { fg: '#DEDBF1' bg: '#794153' attr: 'b' }
        shape_glob_interpolation: { fg: '#82CFC0' attr: 'b' }
        shape_globpattern: { fg: '#82CFC0' attr: 'b' }
        shape_int: { fg: '#D1AFE2' attr: 'b' }
        shape_internalcall: { fg: '#82CFC0' attr: 'b' }
        shape_keyword: { fg: '#D1AFE2' attr: 'b' }
        shape_list: { fg: '#82CFC0' attr: 'b' }
        shape_literal: '#A9BCF2'
        shape_match_pattern: '#A8CA96'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#EAA9BB'
        shape_operator: '#D2BC82'
        shape_or: { fg: '#D1AFE2' attr: 'b' }
        shape_pipe: { fg: '#D1AFE2' attr: 'b' }
        shape_range: { fg: '#D2BC82' attr: 'b' }
        shape_raw_string: { fg: '#DEE0CA' attr: 'b' }
        shape_record: { fg: '#82CFC0' attr: 'b' }
        shape_redirection: { fg: '#D1AFE2' attr: 'b' }
        shape_signature: { fg: '#A8CA96' attr: 'b' }
        shape_string: '#A8CA96'
        shape_string_interpolation: { fg: '#82CFC0' attr: 'b' }
        shape_table: { fg: '#A9BCF2' attr: 'b' }
        shape_vardecl: { fg: '#A9BCF2' attr: 'u' }
        shape_variable: '#D1AFE2'

        foreground: '#DEE0CA'
        background: '#3B3849'
        cursor: '#CED0BA'

        empty: '#A9BCF2'
        header: { fg: '#A8CA96' attr: 'b' }
        hints: '#BEC0AA'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#A8CA96' attr: 'b' }
        search_result: { fg: '#EAA9BB' bg: '#CED0BA' }
        separator: '#CED0BA'
    }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
