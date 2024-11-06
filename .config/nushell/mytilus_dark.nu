# Retrieve the theme settings
export def main [] {
    return {
        binary: '#DCBCEB'
        block: '#B8C9FA'
        cell-path: '#CACCBA'
        closure: '#97D5EE'
        custom: '#F1F3E1'
        duration: '#F1F3E1'
        float: '#F3B7C8'
        glob: '#F1F3E1'
        int: '#DCBCEB'
        list: '#97D5EE'
        nothing: '#F3B7C8'
        range: '#F1F3E1'
        record: '#97D5EE'
        string: '#F3B7C8'

        bool: {|| if $in { '#97D5EE' } else { '#F1F3E1' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#F3B7C8' attr: 'b' }
            } else if $in < 6hr {
                '#F3B7C8'
            } else if $in < 1day {
                '#F1F3E1'
            } else if $in < 3day {
                '#F3B7C8'
            } else if $in < 1wk {
                { fg: '#F3B7C8' attr: 'b' }
            } else if $in < 6wk {
                '#97D5EE'
            } else if $in < 52wk {
                '#B8C9FA'
            } else { '#CACCBA' }
        }

        filesize: {|e|
            if $e == 0b {
                '#CAC7D9'
            } else if $e < 1mb {
                '#97D5EE'
            } else {{ fg: '#B8C9FA' }}
        }

        shape_and: { fg: '#DCBCEB' attr: 'b' }
        shape_binary: { fg: '#DCBCEB' attr: 'b' }
        shape_block: { fg: '#B8C9FA' attr: 'b' }
        shape_bool: '#97D5EE'
        shape_closure: { fg: '#97D5EE' attr: 'b' }
        shape_custom: '#F3B7C8'
        shape_datetime: { fg: '#97D5EE' attr: 'b' }
        shape_directory: '#97D5EE'
        shape_external: '#97D5EE'
        shape_external_resolved: '#97D5EE'
        shape_externalarg: { fg: '#F3B7C8' attr: 'b' }
        shape_filepath: '#97D5EE'
        shape_flag: { fg: '#B8C9FA' attr: 'b' }
        shape_float: { fg: '#F3B7C8' attr: 'b' }
        shape_garbage: { fg: '#CACCBA' bg: '#F3B7C8' attr: 'b' }
        shape_glob_interpolation: { fg: '#97D5EE' attr: 'b' }
        shape_globpattern: { fg: '#97D5EE' attr: 'b' }
        shape_int: { fg: '#DCBCEB' attr: 'b' }
        shape_internalcall: { fg: '#97D5EE' attr: 'b' }
        shape_keyword: { fg: '#DCBCEB' attr: 'b' }
        shape_list: { fg: '#97D5EE' attr: 'b' }
        shape_literal: '#B8C9FA'
        shape_match_pattern: '#F3B7C8'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#F3B7C8'
        shape_operator: '#F1F3E1'
        shape_or: { fg: '#DCBCEB' attr: 'b' }
        shape_pipe: { fg: '#DCBCEB' attr: 'b' }
        shape_range: { fg: '#F1F3E1' attr: 'b' }
        shape_raw_string: { fg: '#F1F3E1' attr: 'b' }
        shape_record: { fg: '#97D5EE' attr: 'b' }
        shape_redirection: { fg: '#DCBCEB' attr: 'b' }
        shape_signature: { fg: '#F3B7C8' attr: 'b' }
        shape_string: '#F3B7C8'
        shape_string_interpolation: { fg: '#97D5EE' attr: 'b' }
        shape_table: { fg: '#B8C9FA' attr: 'b' }
        shape_vardecl: { fg: '#B8C9FA' attr: 'u' }
        shape_variable: '#DCBCEB'

        foreground: '#F1F3E1'
        background: '#2D2B39'
        cursor: '#CAC7D9'

        empty: '#B8C9FA'
        header: { fg: '#F3B7C8' attr: 'b' }
        hints: '#bdae93'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#F3B7C8' attr: 'b' }
        search_result: { fg: '#F3B7C8' bg: '#CACCBA' }
        separator: '#CACCBA'
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
