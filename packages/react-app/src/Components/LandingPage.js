import React from "react";
import backstages from "../assets/backstages.jpg";
import "../App.css";

function LandingPage() {
  return (
    <section className="bg-red-200 text-green-900 bottom-0 relative h-screen">
      {/* <div class="min-h-screen hero-image bg-center bg-cover flex" style="background-image: url(https://images.unsplash.com/photo-1491438590914-bc09fcaaf77a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjE0NTg5fQ);">
       */}
      <div
        className="hero-image bg-right-bottom bg-cover reset-height flex bg-[image:var(--image-url)]"
        style={{ "var(--image-url)": backstages }}
      ></div>
    </section>
  );
}

export default LandingPage;
