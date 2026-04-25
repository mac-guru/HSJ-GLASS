import React from 'react';

export default function Home() {
  return (
    <div style={{
      minHeight: '100vh',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '2rem',
      background: 'linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%)',
      position: 'relative',
      overflow: 'hidden'
    }}>
      {/* Decorative Circles */}
      <div style={{
        position: 'absolute',
        top: '-10%',
        left: '-5%',
        width: '400px',
        height: '400px',
        borderRadius: '50%',
        background: 'rgba(255,255,255,0.1)',
        filter: 'blur(40px)'
      }} />
      <div style={{
        position: 'absolute',
        bottom: '-10%',
        right: '-5%',
        width: '500px',
        height: '500px',
        borderRadius: '50%',
        background: 'rgba(255,255,255,0.1)',
        filter: 'blur(60px)'
      }} />

      <div className="card glass animate-enter" style={{
        width: '100%',
        maxWidth: '440px',
        padding: '3rem 2rem',
        textAlign: 'center',
        position: 'relative',
        zIndex: 10
      }}>
        <h1 style={{ 
          fontSize: '1.75rem', 
          fontWeight: '700', 
          marginBottom: '0.5rem',
          color: 'var(--text-main)'
        }}>
          Himalayan Social Journey
        </h1>
        <p style={{ 
          color: 'var(--text-muted)', 
          marginBottom: '2.5rem',
          fontSize: '0.95rem'
        }}>
          Staff Management System portal
        </p>

        <form style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem', textAlign: 'left' }}>
          <div>
            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500' }}>Email Address</label>
            <input 
              type="email" 
              placeholder="you@himalayansocialjourney.com" 
              style={{ width: '100%' }}
              required 
            />
          </div>
          <div>
            <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500' }}>Password</label>
            <input 
              type="password" 
              placeholder="••••••••" 
              style={{ width: '100%' }}
              required 
            />
          </div>
          
          <button type="submit" className="btn btn-primary" style={{ width: '100%', marginTop: '1rem', padding: '0.875rem' }}>
            Sign In to Workspace
          </button>
        </form>

        <div style={{ marginTop: '2rem', fontSize: '0.875rem', color: 'var(--text-muted)' }}>
          <p>Authorized personnel only. IT Support: admin@hsj.com</p>
        </div>
      </div>
    </div>
  );
}
