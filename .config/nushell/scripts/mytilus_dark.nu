# Retrieve the theme settings
export def main [] {
    return {
        binary: '#D1AEE1'
        block: '#A9BBF2'
        cell-path: '#CDD0BA'
        closure: '#81CFBF'
        custom: '#DDE0CA'
        duration: '#D1BC81'
        float: '#E9A8BB'
        glob: '#DDE0CA'
        int: '#D1AEE1'
        list: '#81CFBF'
        nothing: '#E9A8BB'
        range: '#D1BC81'
        record: '#81CFBF'
        string: '#A7C995'

        bool: {|| if $in { '#81CFBF' } else { '#D1BC81' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#E9A8BB' attr: 'b' }
            } else if $in < 6hr {
                '#E9A8BB'
            } else if $in < 1day {
                '#D1BC81'
            } else if $in < 3day {
                '#A7C995'
            } else if $in < 1wk {
                { fg: '#A7C995' attr: 'b' }
            } else if $in < 6wk {
                '#81CFBF'
            } else if $in < 52wk {
                '#A9BBF2'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#CDD0BA'
            } else if $e < 1mb {
                '#81CFBF'
            } else {{ fg: '#A9BBF2' }}
        }

        shape_and: { fg: '#D1AEE1' attr: 'b' }
        shape_binary: { fg: '#D1AEE1' attr: 'b' }
        shape_block: { fg: '#A9BBF2' attr: 'b' }
        shape_bool: '#81CFBF'
        shape_closure: { fg: '#81CFBF' attr: 'b' }
        shape_custom: '#A7C995'
        shape_datetime: { fg: '#81CFBF' attr: 'b' }
        shape_directory: '#81CFBF'
        shape_external: '#81CFBF'
        shape_external_resolved: '#81CFBF'
        shape_externalarg: { fg: '#A7C995' attr: 'b' }
        shape_filepath: '#81CFBF'
        shape_flag: { fg: '#A9BBF2' attr: 'b' }
        shape_float: { fg: '#E9A8BB' attr: 'b' }
        shape_garbage: { fg: '#DEDAF0' bg: '#784153' attr: 'b' }
        shape_glob_interpolation: { fg: '#81CFBF' attr: 'b' }
        shape_globpattern: { fg: '#81CFBF' attr: 'b' }
        shape_int: { fg: '#D1AEE1' attr: 'b' }
        shape_internalcall: { fg: '#81CFBF' attr: 'b' }
        shape_keyword: { fg: '#D1AEE1' attr: 'b' }
        shape_list: { fg: '#81CFBF' attr: 'b' }
        shape_literal: '#A9BBF2'
        shape_match_pattern: '#A7C995'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#E9A8BB'
        shape_operator: '#D1BC81'
        shape_or: { fg: '#D1AEE1' attr: 'b' }
        shape_pipe: { fg: '#D1AEE1' attr: 'b' }
        shape_range: { fg: '#D1BC81' attr: 'b' }
        shape_raw_string: { fg: '#DDE0CA' attr: 'b' }
        shape_record: { fg: '#81CFBF' attr: 'b' }
        shape_redirection: { fg: '#D1AEE1' attr: 'b' }
        shape_signature: { fg: '#A7C995' attr: 'b' }
        shape_string: '#A7C995'
        shape_string_interpolation: { fg: '#81CFBF' attr: 'b' }
        shape_table: { fg: '#A9BBF2' attr: 'b' }
        shape_vardecl: { fg: '#A9BBF2' attr: 'u' }
        shape_variable: '#D1AEE1'

        foreground: '#DDE0CA'
        background: '#3A3749'
        cursor: '#CDD0BA'

        empty: '#A9BBF2'
        header: { fg: '#A7C995' attr: 'b' }
        hints: '#BDC0AA'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#A7C995' attr: 'b' }
        search_result: { fg: '#E9A8BB' bg: '#CDD0BA' }
        separator: '#CDD0BA'
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
