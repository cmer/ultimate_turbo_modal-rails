# frozen_string_literal: true

module UltimateTurboModal::Flavors
  class Tailwind4 < UltimateTurboModal::Base
    DIALOG_CLASSES = "relative group z-50 p-0 border-none bg-transparent max-w-full max-h-full w-auto h-auto m-0 backdrop:bg-gray-900/50 dark:backdrop:bg-gray-900/80 duration-1000 opacity-0 backdrop:opacity-0 open:opacity-100 open:backdrop:opacity-100 open:transition-opacity"
    CONTENT_WRAPPER_CLASSES = "fixed inset-0 sm:max-w-[80%] md:max-w-3xl sm:mx-auto m-4 overflow-y-auto transform overflow-hidden rounded-lg bg-white text-left shadow transition-all sm:my-8 sm:max-w-3xl dark:bg-gray-800 dark:text-white"
    MAIN_CLASSES = "group-data-[padding=true]:p-4 group-data-[padding=true]:pt-2"
    HEADER_CLASSES = "flex justify-between items-center w-full py-4 rounded-t dark:border-gray-600 group-data-[header-divider=true]:border-b group-data-[header=false]:absolute"
    TITLE_CLASSES = "pl-4"
    TITLE_H_CLASSES = "group-data-[title=false]:hidden text-lg font-semibold text-gray-900 dark:text-white"
    FOOTER_CLASSES = "flex p-4 rounded-b dark:border-gray-600 group-data-[footer-divider=true]:border-t"
    BUTTON_CLOSE_CLASSES = "mr-4 group-data-[close-button=false]:hidden"
    BUTTON_CLOSE_SR_ONLY_CLASSES = "sr-only"
    CLOSE_BUTTON_TAG_CLASSES = "text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
    ICON_CLOSE_CLASSES = "w-5 h-5"
  end
end
