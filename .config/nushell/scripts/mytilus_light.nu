# Retrieve the theme settings
export def main [] {
    return {
        binary: '#654773'
        block: '#435281'
        cell-path: '#474456'
        closure: '#056356'
        custom: '#3A3749'
        duration: '#665217'
        float: '#784153'
        glob: '#3A3749'
        int: '#654773'
        list: '#056356'
        nothing: '#784153'
        range: '#665217'
        record: '#056356'
        string: '#415F30'

        bool: {|| if $in { '#056356' } else { '#665217' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#784153' attr: 'b' }
            } else if $in < 6hr {
                '#784153'
            } else if $in < 1day {
                '#665217'
            } else if $in < 3day {
                '#415F30'
            } else if $in < 1wk {
                { fg: '#415F30' attr: 'b' }
            } else if $in < 6wk {
                '#056356'
            } else if $in < 52wk {
                '#435281'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#474456'
            } else if $e < 1mb {
                '#056356'
            } else {{ fg: '#435281' }}
        }

        shape_and: { fg: '#654773' attr: 'b' }
        shape_binary: { fg: '#654773' attr: 'b' }
        shape_block: { fg: '#435281' attr: 'b' }
        shape_bool: '#056356'
        shape_closure: { fg: '#056356' attr: 'b' }
        shape_custom: '#415F30'
        shape_datetime: { fg: '#056356' attr: 'b' }
        shape_directory: '#056356'
        shape_external: '#056356'
        shape_external_resolved: '#056356'
        shape_externalarg: { fg: '#415F30' attr: 'b' }
        shape_filepath: '#056356'
        shape_flag: { fg: '#435281' attr: 'b' }
        shape_float: { fg: '#784153' attr: 'b' }
        shape_garbage: { fg: '#3A3C2A' bg: '#E9A8BB' attr: 'b' }
        shape_glob_interpolation: { fg: '#056356' attr: 'b' }
        shape_globpattern: { fg: '#056356' attr: 'b' }
        shape_int: { fg: '#654773' attr: 'b' }
        shape_internalcall: { fg: '#056356' attr: 'b' }
        shape_keyword: { fg: '#654773' attr: 'b' }
        shape_list: { fg: '#056356' attr: 'b' }
        shape_literal: '#435281'
        shape_match_pattern: '#415F30'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#784153'
        shape_operator: '#665217'
        shape_or: { fg: '#654773' attr: 'b' }
        shape_pipe: { fg: '#654773' attr: 'b' }
        shape_range: { fg: '#665217' attr: 'b' }
        shape_raw_string: { fg: '#3A3749' attr: 'b' }
        shape_record: { fg: '#056356' attr: 'b' }
        shape_redirection: { fg: '#654773' attr: 'b' }
        shape_signature: { fg: '#415F30' attr: 'b' }
        shape_string: '#415F30'
        shape_string_interpolation: { fg: '#056356' attr: 'b' }
        shape_table: { fg: '#435281' attr: 'b' }
        shape_vardecl: { fg: '#435281' attr: 'u' }
        shape_variable: '#654773'

        foreground: '#3A3749'
        background: '#DDE0CA'
        cursor: '#474456'

        empty: '#435281'
        header: { fg: '#415F30' attr: 'b' }
        hints: '#555264'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#415F30' attr: 'b' }
        search_result: { fg: '#784153' bg: '#474456' }
        separator: '#474456'
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
