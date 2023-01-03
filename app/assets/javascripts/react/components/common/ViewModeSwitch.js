import React from 'react'
import { connect } from 'react-redux'
import { VIEW_MODES } from '../../config/strings'
import actions from '../../actions'

export const ViewModeSwitch = connect(s => ({ switches: s.switches }))
(({ switches, dispatch, onChange }) => {

    const handleSwitch = mode => () => {
      dispatch({ type: actions.switches.setViewMode, mode })
      onChange && onChange(mode)
    }

    const mode = switches.viewMode || VIEW_MODES.LIST

    return (
      <div className="switcher-wrapper">
        <div
          className={`switcher-item${mode === VIEW_MODES.GRID ? ' active' : ''}`}
          onClick={handleSwitch(VIEW_MODES.GRID)}
        >
          <div className="icon-grid"/>
        </div>
        <div
          className={`switcher-item${mode === VIEW_MODES.LIST ? ' active' : ''}`}
          onClick={handleSwitch(VIEW_MODES.LIST)}
        >
          <div className="icon-list"/>
        </div>
      </div>
    )
  }
)

