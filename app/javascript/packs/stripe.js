const button = document.getElementById('stripe-button');
const {sessionId, publishable_key} = button.dataset
button.addEventListener('click', () => {
  const stripe = Stripe(publishable_key);
  stripe.redirectToCheckout({sessionId: sessionId});
});