import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

export default class extends Controller {
  static values = {
    includeBlank: { type: Boolean, default: false},
    optionClass: { type: String, default: "!px-4 !py-2 cursor-pointer flex items-center justify-between" }
  }
  connect() {
    if (this.element.tomselect) return
    this.initTomSelect()
  }

  initTomSelect() {
    if (this.element) {
      const includeBlank = this.includeBlankValue
      const optionClass = this.optionClassValue
      this.tomSelect = new TomSelect(this.element,
        {
          allowEmptyOption: includeBlank,
          hidePlaceholder: true,
          labelField: 'label',
          searchField: ['label'],
          maxOptions: null,
          controlInput: '<input type="text" autocomplete="off" readonly/>',
          ...this.options,
          ...this.callbacks,
          onDropdownOpen: function() {
            const arrow = this.wrapper.querySelector('.ts-control svg')
            if (arrow) {
              arrow.style.transform = 'rotate(180deg)'
            }
          },
          onDropdownClose: function() {
            const arrow = this.wrapper.querySelector('.ts-control svg')
            if (arrow) {
              arrow.style.transform = 'rotate(0deg)'
            }
          },
          onItemAdd: function() {
            this.control_input.classList.add('!w-0')
            this.blur()
          },
          onItemRemove: function() {
            this.blur()
          },
          render: {
            option: function(data, escape) {
              return `
                <div class="${optionClass} ${data.value == '' && includeBlank && data.label != '' ? 'border-b-[0.5px] border-white/50 !pb-1' : ''}">
                  <span>${escape(data.label)}</span>
                </div>
              `
            }
          }
        }
      )

      this.hiddenOriginalSelect()
      this.hiddenInput()
    }
  }

  hiddenOriginalSelect() {
    this.element.classList.add('hidden')
  }

  hiddenInput() {
    const wrapper = this.tomSelect.wrapper
    const input = wrapper.querySelector('input')
    input.classList.add('hidden')
  }
}