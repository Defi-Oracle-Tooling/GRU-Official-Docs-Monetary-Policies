# Analytics Setup Guide

## Overview
Analytics tracking has been prepared in the footer include. Choose one of the following options:

## Option 1: Plausible Analytics (Recommended - Privacy-Focused)

1. Sign up at https://plausible.io
2. Add your domain: `monetary-policies.d-bis.org`
3. Uncomment the Plausible script in `_includes/footer.html`:

```html
<script defer data-domain="monetary-policies.d-bis.org" src="https://plausible.io/js/script.js"></script>
```

**Benefits:**
- GDPR compliant
- No cookies
- Lightweight
- Privacy-focused

## Option 2: Google Analytics 4

1. Create a GA4 property at https://analytics.google.com
2. Get your Measurement ID (format: G-XXXXXXXXXX)
3. Uncomment and update the GA4 script in `_includes/footer.html`:

```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

**Note:** Ensure you have a privacy policy if using GA4.

## Option 3: Matomo (Self-Hosted)

1. Set up Matomo instance
2. Get your tracking code
3. Add to `_includes/footer.html`

## Option 4: Simple Page View Counter

Use GitHub API to track page views (no external service needed).

## Current Status

Analytics is **not active** by default. Choose an option above and uncomment the appropriate code in `_includes/footer.html`.

