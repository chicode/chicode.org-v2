window.onload = () => {
  document.querySelectorAll('.character-form input').forEach((el) => {
    el.onchange = (e) => {
      window.localStorage.setItem(el.name, e.target.value)
    }
  })
}
