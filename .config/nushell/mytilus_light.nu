# Retrieve the theme settings
export def main [] {
    return {
        binary: '#654773'
        block: '#435281'
        cell-path: '#555649'
        closure: '#0F5E76'
        custom: '#2D2C37'
        duration: '#2D2C37'
        float: '#784153'
        glob: '#2D2C37'
        int: '#654773'
        list: '#0F5E76'
        nothing: '#784153'
        range: '#2D2C37'
        record: '#0F5E76'
        string: '#784153'

        bool: {|| if $in { '#0F5E76' } else { '#2D2C37' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#784153' attr: 'b' }
            } else if $in < 6hr {
                '#784153'
            } else if $in < 1day {
                '#2D2C37'
            } else if $in < 3day {
                '#784153'
            } else if $in < 1wk {
                { fg: '#784153' attr: 'b' }
            } else if $in < 6wk {
                '#0F5E76'
            } else if $in < 52wk {
                '#435281'
            } else { '#555649' }
        }

        filesize: {|e|
            if $e == 0b {
                '#55535F'
            } else if $e < 1mb {
                '#0F5E76'
            } else {{ fg: '#435281' }}
        }

        shape_and: { fg: '#654773' attr: 'b' }
        shape_binary: { fg: '#654773' attr: 'b' }
        shape_block: { fg: '#435281' attr: 'b' }
        shape_bool: '#0F5E76'
        shape_closure: { fg: '#0F5E76' attr: 'b' }
        shape_custom: '#784153'
        shape_datetime: { fg: '#0F5E76' attr: 'b' }
        shape_directory: '#0F5E76'
        shape_external: '#0F5E76'
        shape_external_resolved: '#0F5E76'
        shape_externalarg: { fg: '#784153' attr: 'b' }
        shape_filepath: '#0F5E76'
        shape_flag: { fg: '#435281' attr: 'b' }
        shape_float: { fg: '#784153' attr: 'b' }
        shape_garbage: { fg: '#555649' bg: '#784153' attr: 'b' }
        shape_glob_interpolation: { fg: '#0F5E76' attr: 'b' }
        shape_globpattern: { fg: '#0F5E76' attr: 'b' }
        shape_int: { fg: '#654773' attr: 'b' }
        shape_internalcall: { fg: '#0F5E76' attr: 'b' }
        shape_keyword: { fg: '#654773' attr: 'b' }
        shape_list: { fg: '#0F5E76' attr: 'b' }
        shape_literal: '#435281'
        shape_match_pattern: '#784153'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#784153'
        shape_operator: '#2D2C37'
        shape_or: { fg: '#654773' attr: 'b' }
        shape_pipe: { fg: '#654773' attr: 'b' }
        shape_range: { fg: '#2D2C37' attr: 'b' }
        shape_raw_string: { fg: '#2D2C37' attr: 'b' }
        shape_record: { fg: '#0F5E76' attr: 'b' }
        shape_redirection: { fg: '#654773' attr: 'b' }
        shape_signature: { fg: '#784153' attr: 'b' }
        shape_string: '#784153'
        shape_string_interpolation: { fg: '#0F5E76' attr: 'b' }
        shape_table: { fg: '#435281' attr: 'b' }
        shape_vardecl: { fg: '#435281' attr: 'u' }
        shape_variable: '#654773'

        foreground: '#2D2C37'
        background: '#EEF0E1'
        cursor: '#55535F'

        empty: '#435281'
        header: { fg: '#784153' attr: 'b' }
        hints: '#bdae93'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#784153' attr: 'b' }
        search_result: { fg: '#784153' bg: '#555649' }
        separator: '#555649'
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
