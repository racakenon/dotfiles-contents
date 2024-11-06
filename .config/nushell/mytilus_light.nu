# Retrieve the theme settings
export def main [] {
    return {
        binary: '#5B4068'
        block: '#3D4A74'
        cell-path: '#4D4A59'
        closure: '#12546A'
        custom: '#2D2B39'
        duration: '#2D2B39'
        float: '#6C3B4B'
        glob: '#2D2B39'
        int: '#5B4068'
        list: '#12546A'
        nothing: '#6C3B4B'
        range: '#2D2B39'
        record: '#12546A'
        string: '#6C3B4B'

        bool: {|| if $in { '#12546A' } else { '#2D2B39' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#6C3B4B' attr: 'b' }
            } else if $in < 6hr {
                '#6C3B4B'
            } else if $in < 1day {
                '#2D2B39'
            } else if $in < 3day {
                '#6C3B4B'
            } else if $in < 1wk {
                { fg: '#6C3B4B' attr: 'b' }
            } else if $in < 6wk {
                '#12546A'
            } else if $in < 52wk {
                '#3D4A74'
            } else { '#4D4A59' }
        }

        filesize: {|e|
            if $e == 0b {
                '#4C4E3F'
            } else if $e < 1mb {
                '#12546A'
            } else {{ fg: '#3D4A74' }}
        }

        shape_and: { fg: '#5B4068' attr: 'b' }
        shape_binary: { fg: '#5B4068' attr: 'b' }
        shape_block: { fg: '#3D4A74' attr: 'b' }
        shape_bool: '#12546A'
        shape_closure: { fg: '#12546A' attr: 'b' }
        shape_custom: '#6C3B4B'
        shape_datetime: { fg: '#12546A' attr: 'b' }
        shape_directory: '#12546A'
        shape_external: '#12546A'
        shape_external_resolved: '#12546A'
        shape_externalarg: { fg: '#6C3B4B' attr: 'b' }
        shape_filepath: '#12546A'
        shape_flag: { fg: '#3D4A74' attr: 'b' }
        shape_float: { fg: '#6C3B4B' attr: 'b' }
        shape_garbage: { fg: '#4D4A59' bg: '#6C3B4B' attr: 'b' }
        shape_glob_interpolation: { fg: '#12546A' attr: 'b' }
        shape_globpattern: { fg: '#12546A' attr: 'b' }
        shape_int: { fg: '#5B4068' attr: 'b' }
        shape_internalcall: { fg: '#12546A' attr: 'b' }
        shape_keyword: { fg: '#5B4068' attr: 'b' }
        shape_list: { fg: '#12546A' attr: 'b' }
        shape_literal: '#3D4A74'
        shape_match_pattern: '#6C3B4B'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#6C3B4B'
        shape_operator: '#2D2B39'
        shape_or: { fg: '#5B4068' attr: 'b' }
        shape_pipe: { fg: '#5B4068' attr: 'b' }
        shape_range: { fg: '#2D2B39' attr: 'b' }
        shape_raw_string: { fg: '#2D2B39' attr: 'b' }
        shape_record: { fg: '#12546A' attr: 'b' }
        shape_redirection: { fg: '#5B4068' attr: 'b' }
        shape_signature: { fg: '#6C3B4B' attr: 'b' }
        shape_string: '#6C3B4B'
        shape_string_interpolation: { fg: '#12546A' attr: 'b' }
        shape_table: { fg: '#3D4A74' attr: 'b' }
        shape_vardecl: { fg: '#3D4A74' attr: 'u' }
        shape_variable: '#5B4068'

        foreground: '#2D2B39'
        background: '#F1F3E1'
        cursor: '#4C4E3F'

        empty: '#3D4A74'
        header: { fg: '#6C3B4B' attr: 'b' }
        hints: '#bdae93'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#6C3B4B' attr: 'b' }
        search_result: { fg: '#6C3B4B' bg: '#4D4A59' }
        separator: '#4D4A59'
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
