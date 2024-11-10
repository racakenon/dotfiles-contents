# Retrieve the theme settings
export def main [] {
    return {
        binary: '#664774'
        block: '#445282'
        cell-path: '#484557'
        closure: '#066357'
        custom: '#3B3849'
        duration: '#675317'
        float: '#794153'
        glob: '#3B3849'
        int: '#664774'
        list: '#066357'
        nothing: '#794153'
        range: '#675317'
        record: '#066357'
        string: '#415F30'

        bool: {|| if $in { '#066357' } else { '#675317' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#794153' attr: 'b' }
            } else if $in < 6hr {
                '#794153'
            } else if $in < 1day {
                '#675317'
            } else if $in < 3day {
                '#415F30'
            } else if $in < 1wk {
                { fg: '#415F30' attr: 'b' }
            } else if $in < 6wk {
                '#066357'
            } else if $in < 52wk {
                '#445282'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#484557'
            } else if $e < 1mb {
                '#066357'
            } else {{ fg: '#445282' }}
        }

        shape_and: { fg: '#664774' attr: 'b' }
        shape_binary: { fg: '#664774' attr: 'b' }
        shape_block: { fg: '#445282' attr: 'b' }
        shape_bool: '#066357'
        shape_closure: { fg: '#066357' attr: 'b' }
        shape_custom: '#415F30'
        shape_datetime: { fg: '#066357' attr: 'b' }
        shape_directory: '#066357'
        shape_external: '#066357'
        shape_external_resolved: '#066357'
        shape_externalarg: { fg: '#415F30' attr: 'b' }
        shape_filepath: '#066357'
        shape_flag: { fg: '#445282' attr: 'b' }
        shape_float: { fg: '#794153' attr: 'b' }
        shape_garbage: { fg: '#3B3C2A' bg: '#EAA9BB' attr: 'b' }
        shape_glob_interpolation: { fg: '#066357' attr: 'b' }
        shape_globpattern: { fg: '#066357' attr: 'b' }
        shape_int: { fg: '#664774' attr: 'b' }
        shape_internalcall: { fg: '#066357' attr: 'b' }
        shape_keyword: { fg: '#664774' attr: 'b' }
        shape_list: { fg: '#066357' attr: 'b' }
        shape_literal: '#445282'
        shape_match_pattern: '#415F30'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#794153'
        shape_operator: '#675317'
        shape_or: { fg: '#664774' attr: 'b' }
        shape_pipe: { fg: '#664774' attr: 'b' }
        shape_range: { fg: '#675317' attr: 'b' }
        shape_raw_string: { fg: '#3B3849' attr: 'b' }
        shape_record: { fg: '#066357' attr: 'b' }
        shape_redirection: { fg: '#664774' attr: 'b' }
        shape_signature: { fg: '#415F30' attr: 'b' }
        shape_string: '#415F30'
        shape_string_interpolation: { fg: '#066357' attr: 'b' }
        shape_table: { fg: '#445282' attr: 'b' }
        shape_vardecl: { fg: '#445282' attr: 'u' }
        shape_variable: '#664774'

        foreground: '#3B3849'
        background: '#DEE0CA'
        cursor: '#484557'

        empty: '#445282'
        header: { fg: '#415F30' attr: 'b' }
        hints: '#555265'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#415F30' attr: 'b' }
        search_result: { fg: '#794153' bg: '#484557' }
        separator: '#484557'
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
